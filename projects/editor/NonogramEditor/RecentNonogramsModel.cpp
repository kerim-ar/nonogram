#include "RecentNonogramsModel.h"

RecentNonogramsModel::RecentNonogramsModel(QObject * parent)
    :QAbstractListModel(parent)
{
}

int RecentNonogramsModel::rowCount(const QModelIndex &parent) const
{
    return m_recentNonograms.size();
}

QVariant RecentNonogramsModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() > m_recentNonograms.size()) {
        return QVariant();
    }
    if (role == FileName) {
        return QVariant(m_recentNonograms[index.row()]);
    }
    if (role == FilePath) {
        return QVariant(m_recentNonograms[index.row()]);
    }
    return QVariant();
}

QHash<int, QByteArray> RecentNonogramsModel::roleNames() const
{
    QHash<int, QByteArray> ret;
    ret[FilePath] = "filePath";
    ret[FileName] = "fileName";
    return ret;
}

void RecentNonogramsModel::setRecentNonograms(const QStringList &recentNonograms)
{
    m_recentNonograms = recentNonograms;
    emit layoutChanged();
}
