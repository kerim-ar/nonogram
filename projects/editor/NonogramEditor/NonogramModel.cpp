#include "NonogramModel.h"

NonogramModel::NonogramModel(QObject *parent)
    : QAbstractTableModel(parent)
{
}

NonogramModel::~NonogramModel()
{
}

int NonogramModel::rowCount(const QModelIndex &parent) const
{
    return m_matrix.size();
}

int NonogramModel::columnCount(const QModelIndex &parent) const
{
    return m_matrix[0].size();
}

QVariant NonogramModel::data(const QModelIndex &index, int role) const
{
    return QVariant();
}

QString NonogramModel::title() const
{
    return m_title;
}

void NonogramModel::setTitle(const QString &title)
{
    if (m_title != title)
        m_title = title;
}

QString NonogramModel::comment() const
{
    return m_comment;
}

void NonogramModel::setComment(const QString &comment)
{
    if (m_comment != comment)
        m_comment = comment;
}
