#ifndef RECENTNONOGRAMSMODEL_H
#define RECENTNONOGRAMSMODEL_H

#include <QAbstractListModel>
#include <RecentNonogramData.h>

class RecentNonogramsModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit RecentNonogramsModel(QObject * parent = 0);

    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;

private:
    QList<RecentNonogramData> m_recentNonograms;
};

#endif // RECENTNONOGRAMSMODEL_H
